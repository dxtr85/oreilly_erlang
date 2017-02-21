%% Each module loaded into Erlang's virtual machine can have up to two versions,
%% old and current.
%% When we load a module into Erlang's VM for the first time module's current version
%% is being set. When we compile that module again, or when we load different version 
%% of this module in any possible way, then what used to be current version becomes
%% old version, and the most recently loaded version of module becomes current version.

%% Funcions can be called using fully qualified function calls, that is Module:Function(Args),
%% or just by calling Function(Args).
%% When current version has changed and some process calls a method from a module that has been
%% recently changed with use of fully qualified function call, then that process calls the 
%% new function from recently loaded module. From now on all calls to functions in this 
%% process, fully qualified and not, will call methods from the new module.
%% If we used local call to function, the process that calls that function will be refering to
%% old module until a fully qualified call to a function from changed module occurs.

%% Loading Code

%% New code can be loaded with c(Module) shell command, function compile:file(Module),
%% with use of code:load_file(Module), shell command l(Module).
%% This makes the oldest version of given Module to be removed, current version, becomes old
%% and newly loaded version becomes current.
%% To check if a module is loaded one can use Tab key, or function code:is_loaded(Module),
%% which will return location of .beam file, or false if not loaded.
%% code:get_path() will return path used by Erlang to look for compiled modules (beam files).
%% code:root_dir() gives location of Erlang's root dir.

%% If we want to avoid overwriting a module by a newer version, we can use code:stick_dir(Dir),
%% To take this back code:unstick_dir(Dir) can be used. Modules in Dir location will be upgradable
%% again.

%% code:add_patha(Path) will add a new path to beginning of erlang PATH variable,
%% code:add_pathz(Path) will do the same, but adding Path as last entry to PATH
%% -pa -pz are directives of erl command that do the same.

%% Erlang can be run in embedded or interactive modes with use of -mode directive to erl.
%% embedded loads all required modules at the beginning. Any call to nonloaded module will
%% result in runtime exception.

%% code:purge(Module) will remove old Module, but any process that was using it will be killed.
%% code:soft_purge(Module) will remove a module only if no process is using it.

%% .erlang file is located in users HOME directory and contains valid Erlang expressions
%% that are executed every time Erlang starts up.
