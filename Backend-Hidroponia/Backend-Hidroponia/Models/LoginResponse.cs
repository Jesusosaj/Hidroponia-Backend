namespace Backend_Hidroponia.Models
{
    public class LoginResponse
    {
       public string? code { get; set; }
       public string? message { get; set; }
        public LoginResponse(string? Code, string? Message)
        {
            code = Code;
            message = Message;
        }
    }

}
