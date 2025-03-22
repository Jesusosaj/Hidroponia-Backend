using Microsoft.AspNetCore.Mvc;
using Backend_Hidroponia.Models;
using Backend_Hidroponia.Data;
using Microsoft.EntityFrameworkCore;


namespace Backend_Hidroponia.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Login : Controller
    {
        private readonly ApplicationDbContext context;
        
        public Login(ApplicationDbContext context)
        {
            this.context = context;
        }
        [HttpPost]
        public IActionResult LoginValidation(LoginRequest req)
        {
            string? user = req.User;
            string? password = req.Password;

            var validationLogin = context.Usuarios
                            .FromSqlInterpolated($@"
                                SELECT * 
                                FROM usuarios 
                                WHERE correo = {user} 
                                AND contrasena = crypt({password}, contrasena)")
                            .FirstOrDefault();

            if (validationLogin != null)
            {
                return Ok(new LoginResponse("200", "Inicio de sesión exitoso"));
            }
            else
            {
                return Ok(new LoginResponse("401", "Correo o contraseña incorrectos"));
            }
        }




    }
}
