% Nitrogen Web Framework for Erlang
% Copyright (c) 2008-2009 Rusty Klophaus
% See MIT-LICENSE for licensing information.

-module (wf_yaws).
-include ("wf.inc").
-include ("yaws_api.hrl").
-export ([out/1, out/2]).

out(Arg) ->
	Path = Arg#arg.server_path,
	{Module, PathInfo} = wf_platform:route(Path),
	out(Arg, Module, PathInfo).

out(Arg, Module) -> out(Arg, Module, "").

out(Arg, Module, PathInfo) ->
	wf_platform:init(wf_platform_yaws, Arg),
	try 
		wf_handle:handle_request(Module, PathInfo)
	catch _ : _ -> ?PRINT(erlang:get_stacktrace())
	end.