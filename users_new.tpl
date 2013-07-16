<h1>Create an account:</h1>
<form method="post" action="/users/new">
  <p>Email: <input type="text" name="email" size="30" /></p>
  <p>Password: <input type="password" name="password" size="30" /></p>
%if message:
  <p>{{message}}</p>
%end
  <p><input type="submit"></p>
</form>
