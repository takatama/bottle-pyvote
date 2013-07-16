<h1>Modify your account:</h1>
<form method="post" action="/users/update">
  <p>Email: <input type="text" name="email" size="30" value="{{email}}"/></p>
  <p>Password: <input type="password" name="password" size="30" value="{{password}}"/></p>
%if message:
  <p>{{message}}</p>
%end
  <p><input type="submit"></p>
</form>
