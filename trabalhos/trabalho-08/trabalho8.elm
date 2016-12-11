import Html exposing (text)

type alias Env = (String -> Int)
zero : Env
zero = \ask -> 0

type Exp = Var String
         | Const String
         | Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Mult Exp Exp
         | Div Exp Exp
         | Expo Exp Exp

type Prog = Attr String Exp
         | Seq Prog Prog
         | If Exp Prog Prog
         | While Exp Prog
         | Def String Exp

evalExp : Exp -> Env -> Int
evalExp exp env =
    case exp of
        Var str        -> (env str)
        Const const    -> (env const)
        Num nb         -> nb
        Add nb1 nb2    -> (evalExp nb1 env) + (evalExp nb2 env)
        Sub nb1 nb2    -> (evalExp nb1 env) - (evalExp nb2 env)
        Mult nb1 nb2   -> (evalExp nb1 env) * (evalExp nb2 env)
        Div nb1 nb2    -> (evalExp nb1 env) // (evalExp nb2 env)
        Expo nb1 nb2   -> (evalExp nb1 env) ^ (evalExp nb2 env)

evalProg : Prog -> Env -> Env
evalProg s env =
    case s of
        Attr var exp   ->
            let
                val = (evalExp exp env)
            in
                \ask   -> if ask==var then val else (env ask)
        Seq s1 s2 -> (evalProg s2 (evalProg s1 env))
        If cond progt progf  ->
                if (evalExp cond env) /= 0 then
                    (evalProg progt env)
                else
                    (evalProg progf env)
        While cond prog1 ->
            if (evalExp cond env) /= 0  then 
                (evalProg (Seq prog1 s) env)
            else 
                env
        Def const exp ->
            let 
                val = (evalExp exp env) 
            in 
                if (env const) == 0 then 
                    \ask -> 
                        if (ask /= const) then
                            (env ask)  
                        else 
                            val 
                else 
                    env
lang : Prog -> Int
lang p = ((evalProg p zero) "ret")

p1 : Prog -- Teste1 (Seq, Attr, Add e If)
p1 = (Seq
        (Attr "x" (Add (Num 11) (Num 9)))
        (If (Var "x")
            (Attr "ret" (Var "x"))
            (Attr "ret" (Num 100))))

p2 : Prog -- Teste1 (Seq, Sub e Expo)
p2 =  (Seq
            (Attr "ret" (Sub (Num 11) (Num 9)))
            (Attr "ret" (Expo (Var "ret") (Num 2)))
        )

p3 : Prog -- Teste3 (While)
p3 =    (Seq  
            (Attr "x"(Num 1))
            (Seq
                (Attr "i" (Num 5))
                (While (Var "i")
                    (Seq 
                        (Seq
                            (Attr "x" (Add (Var "x") (Var "i")))
                            (Attr "i"(Sub (Var "i") (Num 1)))
                        )
                        (Attr "ret" (Var "x"))
                    )
                )
            )
        )


p4: Prog -- Teste4 (Def)
p4 =    (Seq
            (Def "NOTFOUND" (Num 404))
            (Attr "ret" (Const "NOTFOUND"))
        )

p5 : Prog -- Teste5 (Mult e Div(Truncamento do valor)) 15/4= 3,75(Truncamento) = 3
p5 = (Attr "ret" (Mult (Num 3) (Div (Num 15) (Num 4))))

--main = text (toString (lang p1))
--main = text (toString (lang p2))
--main = text (toString (lang p3))
--main = text (toString (lang p4))
main = text (toString (lang p5))
