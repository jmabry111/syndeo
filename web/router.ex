defmodule Syndeo.Router do
  use Syndeo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Syndeo.TokenVerifier
    plug Syndeo.AttendeeSession
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end
  scope "/", Syndeo do
    pipe_through [:browser]
    resources "/attendees", AttendeeController, only: [:new, :create]
    get "/", AttendeeController, :new
    resources "/tokenized_email", TokenizedEmailController, only: [:create]
    resources "/meals", MealController
  end

  scope "/", Syndeo do
    pipe_through [:browser, Syndeo.RequireAttendee]
    resources "/attendees", AttendeeController, only: [:show]
    resources "/attendees", AttendeeController, only: [] do
      resources "/weekly_info", WeeklyInfoController, only: [:new, :create, :index, :delete]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Syndeo do
  #   pipe_through :api
  # end
end
