using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarPartsStore.API.Models
{
    public class Order
    {
        [Key]
        public int Id { get; set; }
        
        [Required]
        public string OrderNumber { get; set; } = GenerateOrderNumber();
        
        [Required]
        public int UserId { get; set; }
        
        [Required]
        [Column(TypeName = "decimal(18,2)")]
        public decimal TotalAmount { get; set; }
        
        [Column(TypeName = "decimal(18,2)")]
        public decimal DiscountAmount { get; set; } = 0;
        
        [Column(TypeName = "decimal(18,2)")]
        public decimal TaxAmount { get; set; } = 0;
        
        [Column(TypeName = "decimal(18,2)")]
        public decimal ShippingCost { get; set; } = 0;
        
        [Required]
        [Column(TypeName = "decimal(18,2)")]
        public decimal FinalAmount { get; set; }
        
        [Required]
        public OrderStatus Status { get; set; } = OrderStatus.Pending;
        
        [Required]
        public PaymentStatus PaymentStatus { get; set; } = PaymentStatus.Pending;
        
        [StringLength(50)]
        public string PaymentMethod { get; set; } = string.Empty;
        
        [StringLength(100)]
        public string TransactionId { get; set; } = string.Empty;
        
        [Required]
        [StringLength(500)]
        public string ShippingAddress { get; set; } = string.Empty;
        
        [StringLength(20)]
        public string ShippingTrackingNumber { get; set; } = string.Empty;
        
        [StringLength(1000)]
        public string Notes { get; set; } = string.Empty;
        
        public DateTime OrderDate { get; set; } = DateTime.UtcNow;
        public DateTime? PaymentDate { get; set; }
        public DateTime? ShippedDate { get; set; }
        public DateTime? DeliveredDate { get; set; }
        
        // Navigation properties
        [ForeignKey("UserId")]
        public virtual User User { get; set; } = null!;
        
        public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
        
        private static string GenerateOrderNumber()
        {
            return $"ORD-{DateTime.UtcNow:yyyyMMdd}-{Guid.NewGuid().ToString().Substring(0, 8).ToUpper()}";
        }
    }
    
    public enum OrderStatus
    {
        Pending,
        Processing,
        Shipped,
        Delivered,
        Cancelled,
        Returned
    }
    
    public enum PaymentStatus
    {
        Pending,
        Paid,
        Failed,
        Refunded,
        PartiallyRefunded
    }
}