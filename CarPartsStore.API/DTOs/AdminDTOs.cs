namespace CarPartsStore.API.DTOs
{
    public class DashboardStatsDto
    {
        public int TotalProducts { get; set; }
        public int TotalOrders { get; set; }
        public decimal TotalRevenue { get; set; }
        public int TotalUsers { get; set; }
        public int LowStockProducts { get; set; }
        public int PendingOrders { get; set; }
    }
}