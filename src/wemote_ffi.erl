-module(wemote_ffi).

-export([call/3]).

call(Node, Fun, Timeout) ->
    T = case Timeout of
        infinity -> infinity;
        {milliseconds, Value} when is_integer(Value) -> Value
    end,
    try erpc:call(Node, Fun, T) of
        Result -> {ok, Result}
    catch
        throw:Thrown -> {error, {threw, Thrown}};
        exit:{exception, Exception} -> {error, {exception, Exception}};
        exit:{signal, ExitReason} -> {error, {exited, ExitReason}};
        exit:Other -> {error, {other, Other}};
        error:{exception, ErrorReason, StackTrace} -> {error, {runtime_error, ErrorReason, StackTrace}};
        error:{erpc, Reason} -> {error, {rpc_error, Reason}};
        error: Other -> {error, {other, Other}};
    end.
