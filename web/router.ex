defmodule ConnectionCard.Router do
  use ConnectionCard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ConnectionCard.TokenVerifier
    plug ConnectionCard.AttendeeSession
    if Mix.env == :test do
      plug ConnectionCard.SessionBackdoor
    end
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end
  scope "/", ConnectionCard do
    pipe_through [:browser]
    resources "/attendees", AttendeeController, only: [:new, :create]
    get "/", AttendeeController, :new
    resources "/tokenized_email", TokenizedEmailController, only: [:create]
  end

  scope "/", ConnectionCard do
    pipe_through [:browser, ConnectionCard.RequireAttendee]
    resources "/attendees", AttendeeController, only: [:show]
    resources "/attendees", AttendeeController, only: [] do
      resources "/weekly_info", WeeklyInfoController, only: [:new, :create]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConnectionCard do
  #   pipe_through :api
  # end
end
