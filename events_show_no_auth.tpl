<h1>{{name}}</h1>
<p>{{description}}</p>
<div class="alert alert-info">
投票するには<strong><a href="/users/new?to=/events/show/{{id}}">アカウントを作成</a></strong>するか、<strong><a href="/users/login?to=/events/show/{{id}}">ログイン</a></strong>してください
</div>
<dl>
%for team in teams:
      <dt>{{team['name']}}</dt>
      <dd>{{team['description']}}</dd>
%end
</dl>
<form method="get" action="/teams/new/{{id}}">
  <input type="submit" value="add a team" />
</form>
%rebase layout title='Event details'
