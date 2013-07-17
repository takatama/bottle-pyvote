<h1>Login:</h1>
<form method="post" action="/users/login">
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
<p><a href="/users/new?to={{to}}"/>Create a new account</a></p>
%else:
<p><a href="/users/new"/>Create a new account</a></p>
%end
%rebase layout title="Login"
