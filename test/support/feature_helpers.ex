defmodule ConnectionCard.FeatureHelpers do
  use Hound.Helpers
  import ConnectionCard.RoleHelpers

  def click_on(text) do
    text
    |> find_element_with_text
    |> click
  end

  def find_element_with_text(text) do
    case find_all_elements(:link_text, text) do
      [] -> find_some_element_with_text(text)
      [element] -> element
      _multiple_elements -> raise "Multiple elements found with the text #{text}"
    end
  end

  def find_some_element_with_text(text) do
    find_button_with_text(text) ||
      find_input_with_text(text) ||
      find_label_with_text(text) ||
      raise "No element found with the text '#{text}'"
  end

  defp find_button_with_text(text) do
    find_all_elements(:tag, "button")
    |> Enum.find(&(String.contains?(inner_text(&1), text)))
  end

  defp find_label_with_text(text) do
    find_all_elements(:tag, "label")
    |> Enum.find(&(inner_text(&1) |> String.trim =~ text))
  end

  def find_input_with_text(text) do
    find_all_elements(:css, "input[value='#{text}']")
    |> List.first
  end

  def find_text_matching(elements, text) do
    Enum.find(elements, fn (element) -> inner_text(element) =~ text end)
  end

  def fill_in(type, field_name, [with: text]) do
    fill_field({:name, "#{type}[#{field_name}]"}, text)
  end

  def flash_text do
    text_for_role("flash")
  end

  def submit do
    submit_element({:css, "input[type=submit],button[type=submit]"})
  end

  def ignore_confirm_dialog do
    execute_script("window.confirm = function(){return true;}")
  end

  def image_named(name) do
    find_all_elements(:tag, "img")
    |> any_have_src_matching?(name)
  end

  def any_have_src_matching?(elements, name) do
    Enum.any? elements, fn(e) ->
      attribute_value(e, "src") |> String.contains?(name)
    end
  end

  def select_selectize_option(name) do
    find_element(:css, ".selectize-input")
    |> click

    find_all_elements(:css, "[data-value]")
    |> find_text_matching(name)
    |> click
  end

  def select(option_text, [from: select_name]) do
    find_element(:css, "select[name*=#{select_name}]")
    |> find_all_within_element(:css, "option")
    |> Enum.find(&(inner_text(&1) == option_text))
    |> click
  end

  def attach_file(element, file_name) do
    import Hound.RequestUtils
    session_id = Hound.current_session_id
    make_req(:post, "session/#{session_id}/element/#{element}/value", %{value: ["#{file_name}"]})
  end
end
