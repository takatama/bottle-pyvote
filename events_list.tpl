<h1>Events:</h1>
<dl>
%for event in events:
  <dt><a href="/events/show/{{event[0]}}">{{event[1]}}</a></dt>
  <dd>{{event[2]}}</dd>
%end
</dl>
<form method="post" action="/events/new">
  <input type="submit" value="add an event" />
</form>
