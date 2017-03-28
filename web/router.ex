defmodule Syndeo.Router do
  use Syndeo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    if Mix.env == :test do
      plug Syndeo.Plug.SessionBackdoor
    end
    plug Syndeo.TokenVerifier
    plug Syndeo.AttendeeSession
    plug Doorman.Login.Session
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  scope "/", Syndeo do
    pipe_through [:browser]
    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true
    resources "/attendees", AttendeeController, only: [:new, :create]
    get "/", AttendeeController, :new
    resources "/tokenized_email", TokenizedEmailController, only: [:create]
    resources "/meals", MealController
    resources "/ics", IcsController, only: [:show]
  end

  scope "/", Syndeo do
    pipe_through [:browser, Syndeo.RequireAttendee]
    resources "/attendees", AttendeeController, only: [:show]
    resources "/attendees", AttendeeController, only: [] do
      resources "/weekly_info", WeeklyInfoController, only: [:new, :create, :index, :delete]
    end
  end

  scope "/admin", Syndeo, as: :admin do
    pipe_through [:browser, Syndeo.RequireAdmin]
    resources "/users", Admin.UserController, only: [:index, :create, :new, :edit, :update, :delete]
    resources "/attendees", Admin.AttendeeController, only: [:index, :edit, :delete, :show]
  end
end
