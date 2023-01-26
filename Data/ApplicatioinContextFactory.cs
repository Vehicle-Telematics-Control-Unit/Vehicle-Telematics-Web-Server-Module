using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace Server.Data
{
    public class ApplicatioinContextFactory : IDesignTimeDbContextFactory<ApplicationDbContext>
    {
        public ApplicationDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
            optionsBuilder.UseNpgsql(@"Server=localhost;Port=5432;Database=TCU;User Id=postgres;Password=postgres;");

            return new ApplicationDbContext(optionsBuilder.Options);
        }
    }
}
