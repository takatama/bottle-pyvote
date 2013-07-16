<h1>Create an account:
<form method="post" action="{{action}}">
  <p>Email: <input type="text" name="email" size="30" /></p>
  <p>Password: <input type="password" name="password" size="30" /></p>
%if message:
  <p>{{message}}</p>
%end
  <p><input type="submit"></p>
</form>
