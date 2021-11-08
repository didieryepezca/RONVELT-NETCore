using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

using Ronvelt.Models.Entities;

namespace Ronvelt.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }
        public ApplicationDbContext()

        {
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            // Customize the ASP.NET Identity model and override the defaults if needed.
            // For example, you can rename the ASP.NET Identity table names and more.
            // Add your customizations after calling base.OnModelCreating(builder);
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionBuilder)
        {



            optionBuilder.UseSqlServer("Server=localhost;" +
                   "Database=Praxis;" +
                   "Trusted_Connection=True;" +
                   "MultipleActiveResultSets=True");
        }

        public virtual DbSet<Cliente> Cliente { get; set; }
        public virtual DbSet<Alquiler> Alquiler { get; set; }
        public virtual DbSet<Obra> Obra { get; set; }
        public virtual DbSet<Equipo> Equipo { get; set; }


    }
}
