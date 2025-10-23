<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<title>Login | Sistem POS</title>
</head>
<body>
<h2>Login Sistem POS</h2>

<form method="POST" action="">
    <input type="text" name="username" placeholder="Username" required><br><br>
    <input type="password" name="password" placeholder="Password" required><br><br>
    <button type="submit">Login</button>
</form>

<?php if (!empty($data['error'])): ?>
    <p style="color:red;"><?= $data['error'] ?></p>
<?php endif; ?>
</body>
</html>
