using Firebase.Auth;
using Firebase.Auth.Providers;

namespace AzurLane.Classes
{
    internal static class FirebaseAuth
    {
        private static FirebaseAuthClient client = new FirebaseAuthClient(
            new FirebaseAuthConfig()
            {
                ApiKey = FirebaseConfigConstant.API_KEY,
                AuthDomain = FirebaseConfigConstant.DOMAIN,
                Providers = [new EmailProvider()],
            }
        );

        public static UserCredential Log(string email, string password)
        {
            return client.SignInWithEmailAndPasswordAsync(email, password).Result;
        }

        public static UserCredential Sign(string email, string password, string name)
        {
            return client.CreateUserWithEmailAndPasswordAsync(email, password).Result;
        }

        public static void SignOut()
        {
            client.SignOut();
        }
    }
}
