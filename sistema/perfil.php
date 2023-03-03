
                    <?php include_once "includes/header.php"; ?>       
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="ESTUDIANTE de  SISTEMAS">
  <meta name="author" content="">
  <link rel="icon" type="image/jpeg" href="./sistema/img/logo.jpeg">
  <title>LINCERIA MAHAL</title>

  <!-- Custom fonts for this template-->
  <link href="sistema/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <!-- Custom styles for this template-->
  <link href="sistema/css/sb-admin-2.min.css" rel="stylesheet">


</head>

<body class="bg-color1">

  <div class="container">
    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-1">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
    
		
                
            <div class="card-header bg-primary text-white">
					Información Personal
				</div>
				<div class="card-body">
			
					<div class="form-group">
						<label>Nombre: <strong><?php echo $_SESSION['nombre']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Correo: <strong><?php echo $_SESSION['email']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Rol: <strong><?php echo $_SESSION['rol_name']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Usuario: <strong><?php echo $_SESSION['user']; ?></strong></label>
					</div>


            

            </div>
        </div>
    </div>


   
          </div>
        </div>

            
        </div>
                  
        </div>
         


  
  <!-- Bootstrap core JavaScript-->
  <script src="sistema/vendor/jquery/jquery.min.js"></script>
  <script src="sistema/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="sistema/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="sistema/js/sb-admin-2.min.js"></script>

</body>
<?php include_once "includes/footer.php"; ?> 
</html>
