import gleam/bool
import gleam/list
import gleam/result
import gleam/string
import util

pub type BNF(i) {
  Id(String)
  Drop(i)
  End(i)
  Seq(List(BNF(i)))
  Opt(BNF(i))
  Rep(BNF(i))
}

pub type LBNF(i) =
  List(#(String, #(String, BNF(i))))

pub type AST {
  Node(label: String, children: List(AST))
}

pub fn show_ast(ast: AST) {
  use <- bool.guard(ast.children |> list.is_empty, ast.label |> util.quote)
  let children_str = ast.children |> list.map(show_ast) |> string.join(", ")
  ast.label <> "(" <> children_str <> ")"
}

pub type Context(a) {
  Context(
    drop: fn(a, a) -> Result(a, Nil),
    empty: a,
    to_string: fn(a) -> String,
  )
}

pub fn eat_rules(i, grammar, ctx) {
  grammar
  |> list.fold_until(Error(Nil), fn(acc, rule) {
    let r = eat_rule(i, rule, grammar, ctx)
    use <- bool.guard(r |> result.is_ok, r |> list.Stop)
    acc |> list.Continue
  })
}

pub fn eat_rule(i, rule, grammar, ctx) {
  let #(label, #(_variant, bnf)) = rule
  echo label
  use #(i, asts) <- result.try(drop_bnf(i, bnf, grammar, ctx))
  #(i, Node(label, asts)) |> Ok
}

pub fn drop_bnf(i, bnf, grammar, ctx: Context(a)) {
  case bnf {
    Id(label) ->
      grammar
      |> list.key_filter(label)
      |> list.fold_until(Error(Nil), fn(acc, variant_bnf) {
        let #(_variant, other_bnf) = variant_bnf
        case drop_bnf(i, other_bnf, grammar, ctx) {
          Ok(r) -> {
            let #(i, asts) = r
            #(i, [Node(label, asts)]) |> Ok |> list.Stop
          }
          _ -> acc |> list.Continue
        }
      })
    Drop(drop_i) -> {
      echo drop_i |> ctx.to_string
      use i <- result.try(i |> ctx.drop(drop_i))
      let drop_i_str = drop_i |> ctx.to_string
      #(i, [Node(drop_i_str, [])]) |> Ok
    }
    End(drop_i) -> {
      echo drop_i |> ctx.to_string
      use i <- result.try(i |> ctx.drop(drop_i))
      use <- bool.guard(i != ctx.empty, Error(Nil))
      #(ctx.empty, []) |> Ok
    }
    Seq(bnfs) ->
      bnfs
      |> list.try_fold(#(i, []), fn(acc, other_bnf) {
        let #(i, labels) = acc
        use #(i, labels2) <- result.try(drop_bnf(i, other_bnf, grammar, ctx))
        #(i, labels |> list.append(labels2)) |> Ok
      })
    Opt(other_bnf) ->
      drop_bnf(i, other_bnf, grammar, ctx)
      |> result.unwrap(#(i, []))
      |> Ok
    Rep(other_bnf) ->
      case drop_bnf(i, other_bnf, grammar, ctx) {
        Ok(#(i, labels)) -> {
          use #(i, labels2) <- result.try(drop_bnf(i, bnf, grammar, ctx))
          #(i, labels |> list.append(labels2)) |> Ok
        }
        _ -> Ok(#(i, []))
      }
  }
}
