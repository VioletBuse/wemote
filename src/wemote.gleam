import gleam/dynamic.{type Dynamic}
import gleam/erlang/node.{type Node}

pub type Timeout {
  Infinity
  Milliseconds(Int)
}

pub type RpcError {
  /// This will never happen, but is included for completeness,
  /// in case we add functionality in future that can return this.
  Badarg
  /// This is returned if the current node cannot establish a
  /// connection to the remote node.
  Noconnection
  /// This is returned if there is some sort of limit on the other end,
  /// most commonly a failure to start a process.
  SystemLimit
  /// The operation timed out. The function may or may not be applied
  Timeout
  /// The remote node does not support erpc
  Notsup
}

pub type Error {
  /// The supplied function called throw(x), and x is returned here.
  Threw(thrown: Dynamic)
  /// The supplied function called exit(x), and this returns the exit reason.
  Exception(exit_reason: Dynamic)
  /// The process running the function was terminated,
  /// and the exit reason is returned here.
  Exited(exit_reason: Dynamic)
  /// The supplied function contains a runtime error.
  RuntimeError(reason: Dynamic, stack_trace: Dynamic)
  /// The rpc backend encountered an error.
  RpcError(RpcError)
  /// Some other unknown error occurred.
  /// Feel free to panic on this, it shouldn't
  /// ever happen. Included just in case.
  Other(Dynamic)
}

@external(erlang, "wemote_ffi", "call")
pub fn call(node: Node, fun: fn() -> a, timeout: Timeout) -> Result(a, Error)
