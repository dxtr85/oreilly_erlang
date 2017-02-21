%% What to do in Erl console:
%% Compile db from db1
%% compile db_server
%% This is only to show how it works, in production we should never upgrade like this!!!

%% SASL application has tools for software upgrade.

db:module_info().
db_server:start().
db_server:write(francesco, san_francisco).
db_server(write(alison, london).
db_server:read(alison).
db_server:read(martin).
code:add_patha(DirToDB2).
code:load_file(db).
code:soft_purge(db).
db_server:upgrade(dict).
db:module_info().
db_server:write(martin, cairo).
db_server:read(francesco).
db_server:read(martin).
