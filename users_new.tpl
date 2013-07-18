<h1>Create an account:</h1>
<form method="post" action="/users/new">
%if to:
  <input type="hidden" name="to" value="{{to}}" />
%end
  <p>Email: <input type="text" name="email" size="30" /></p>
  <p>Password: <input type="password" name="password" size="30" /></p>
%if message:
  <p>{{message}}</p>
%end
  <p><input type="submit"></p>
</form>
%if to:
Login from <a href="/users/login?to={{to}}">here</a> if you already have an account.</a>
%else:
Login from <a href="/users/login">here</a> if you already have an account.</a>
%end
%rebase layout title='Create an account'
