defmodule ConnectionCard.Factory do
  use ExMachina.Ecto, repo: ConnectionCard.Repo

  def attendee_factory do
    %ConnectionCard.Attendee{
      service: "9:00",
      name: sequence(:name, &"John P Churchgoer#{&1}"),
      street: sequence(:street, &"#{&1} Cherub Ave"),
      city: "Pearly Gates",
      state: "VA",
      zip: "12345",
      email: sequence(:email, &"myemail#{&1}@example.com"),
      phone: "5555551234",
      sms: true,
      membership_status: "Member",
      age_range: "Adult",
    }
  end

  def weekly_info_factory do
    %ConnectionCard.WeeklyInfo{
      week_date: Timex.today,
      attending_meal: true,
      num_kids: 2,
      num_teens: 1,
      num_adults: 2,
      contact: "Becoming a follower of Christ",
      prayers: "Pray for all humanity",
    }
  end

  def save(struct) do
    module_name = struct.__struct__
    params = Map.from_struct(struct)

    module_name
    |> struct(%{})
    |> module_name.changeset(params)
    |> ConnectionCard.Repo.insert!
  end
end
