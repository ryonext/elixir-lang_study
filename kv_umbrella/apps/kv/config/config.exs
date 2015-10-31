use Mix.Config

config :kv, :routing_table,
       [{?a..?m, :"foo@Abbotsford"},
         {?n..?z, :"bar@Abbotsford"}]

