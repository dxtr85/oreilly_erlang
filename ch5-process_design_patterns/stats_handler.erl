-module(stats_handler).
-export([init/1, terminate/1, handle_event/2]).

init(StatsTable) -> StatsTable.

terminate(StatsTable) -> {statsTable, StatsTable}.

handle_event({Type, _Id, Descr}, StatsTable) ->
  case lists:keysearch({Type, Descr}, 1, StatsTable) of
    false ->
	  [{{Type, Descr}, 1}|StatsTable];
	{value, {{Type, Descr}, Value}} -> lists:keyreplace({Type, Descr}, 1, StatsTable, {{Type, Descr}, Value + 1})
end.

