#### Intermission - equivalence
1. λxy.xz == λmn.mz
2. λxy.xxy == λa(λb.aab)
3. λxyz.zx == λtos.st
### Chapter Exercises
#### Combinators?
1. λx.xxx - yes
2. λxy.zx - no
3. λxyz.xy(zx) - yes
4. λxyz.xy(zxy) - yes
5. λxy.xy(zxy) - no
#### Normal form or diverge?
1. λx.xxx - Normal
2. (λz.zz)(λy.yy) - Diverge
3. (λx.xxx)z - Normal
#### Beta reduce
1. (λabc.cba)zz(λwv.w) -> z
2. (λx.λy.xyy)(λa.a)b -> bb
3. (λy.y)(λx.xx)(λz.zq) -> qq
4. (λz.z)(λz.zz)(λz.zy) -> yy
5. (λx.λy.xyy)(λy.y)y -> yy
6. (λa.aa)(λb.ba)c -> aac
7. (λxyz.xz(yz))(λx.z)(λx.a) -> λz1.za