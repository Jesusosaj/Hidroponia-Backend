using System;
using System.Collections.Generic;

namespace Backend_Hidroponia.Models;

public partial class Usuario
{
    public int Id { get; set; }

    public string NombreUsuario { get; set; } = null!;

    public string Correo { get; set; } = null!;

    public string Contrasena { get; set; } = null!;

    public int RolId { get; set; }

    public int EstadoId { get; set; }

    public DateTime? CreadoEn { get; set; }

    public DateTime? ActualizadoEn { get; set; }

    public virtual Estado Estado { get; set; } = null!;

    public virtual Role Rol { get; set; } = null!;
}
