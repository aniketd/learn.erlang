-module(kitty_gen_server).
-behavior(gen_server).

-export(export_all).

-record(cat, {name, color=green, description}).

%%% API
start_link() -> gen_server:start_link(?MODULE, [], []).

order_cat(Pid, Name, Color, Description) ->
    gen_server:call(Pid, {order, Name, Color, Description}).

return_cat(Pid, Cat = #cat{}) ->
    gen_server:cast(Pid, {return, Cat}).

close_shop(Pid) ->
    gen_server:call(Pid, terminate).


%%% for gen_server
init([]) -> {ok, []}.

handle_call({order, Name, Color, Description}, _From, Cats) ->
    if Cats =:= [] ->
        {reply, make_cat(Name, Color, Description), Cats};
       Cats =/= [] ->
        {reply, hd(Cats), tl(Cats)}
    end;
handle_call(terminate, _From, Cats) ->
    {stop, normal, ok, Cats}.

handle_cast({return, Cat = #cat{}}, Cats) ->
    {noreply, [Cat|Cats]}.

handle_info(Msg, Cats) ->
    io:format("Unexpected message: ~p~n", [Msg]),
    {noreply, Cats}.

terminate(normal, Cats) ->
    [io:format("~p was set free.~n", [C#cat.name]) || C <- Cats],
    ok.


%%% Private
make_cat(Name, Color, Description) ->
    #cat{name=Name, color=Color, description=Description}.
