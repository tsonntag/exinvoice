defmodule Exinvoice.Events.GoogleCalendar do
  @calendar_id "google@sonntagsbox.de"

  require Logger
  alias Exinvoice.Events.Event
  alias Exinvoice.Repo

  def save_events_for_month(year, month, calendar_id ) do
    events = get_events_for_month(year, month, calendar_id)

    Enum.each(events, fn event ->
      Logger.info("Inserting event: #{inspect(event)}")
      event
      |> Repo.insert(on_conflict: :nothing)
    end)
  end

  def get_events_for_month(year, month, calendar_id)
      when is_integer(year) and is_integer(month) do
    {:ok, month_date} = Date.new(year, month, 1)
    get_events_for_month(month_date, calendar_id)
  end

  def get_events_for_month(%Date{} = month_date, calendar_id) do
    {time_min, time_max} = Event.first_and_last_date_of_month(month_date)

    get_events(time_min, time_max, calendar_id)
    |> Enum.map(&to_event/1)
  end

  def get_events(time_min, time_max, calendar_id) do
    {:ok, token} = get_token()

    get_events_from_calendar(calendar_id, time_min, time_max, token)
  end

  defp get_token() do
    scope = "https://www.googleapis.com/auth/calendar.readonly"

    Goth.Token.for_scope(scope)
  end

  defp get_events_from_calendar(calendar_id, time_min, time_max, token) do
    {:ok, resp} =
      Req.get("https://www.googleapis.com/calendar/v3/calendars/#{calendar_id}/events",
        headers: [
          Authorization: "Bearer #{token.token}",
          Accept: "application/json"
        ],
        params: [
          timeMin: DateTime.to_iso8601(time_min),
          # "#{time_min, time_max}-01-01T00:00:00Z",
          # "#{time_min, time_max + 1}-01-01T00:00:00Z",
          timeMax: DateTime.to_iso8601(time_max),
          singleEvents: true,
          maxResults: 2500,
          orderBy: "startTime",
          timeZone: "Europe/Brussels"
        ]
      )

    resp.body["items"]
    |> IO.inspect(label: "Calendar Events")
  end

  defp to_event(event_map) do
    start_datetime = event_map["start"]["dateTime"] || event_map["start"]["date"]
    #   start_tz = ebin_time = event_map["end"]["timeZone"]
    {:ok, from_datetime, _utc_offset} = DateTime.from_iso8601(start_datetime)

    end_datetime = event_map["end"]["dateTime"] || event_map["end"]["date"]
    #    end_tz = event_map["end"]["timeZone"]
    {:ok, to_datetime, _utc_offset} = DateTime.from_iso8601(end_datetime)

    %Event{
      summary: event_map["summary"],
      from_datetime: from_datetime,
      to_datetime: to_datetime
    }
  end
end
