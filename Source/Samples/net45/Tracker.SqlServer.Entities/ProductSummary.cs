//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Tracker.SqlServer.Entities
{
    using System;
    using System.Collections.Generic;
    
    public partial class ProductSummary
    {
        public string ProductId { get; set; }
        public string Name { get; set; }
        public decimal AvgPrice { get; set; }
        public bool Verified { get; set; }
        public Nullable<System.DateTime> Date { get; set; }
    
        public virtual Product Product { get; set; }
    }
}