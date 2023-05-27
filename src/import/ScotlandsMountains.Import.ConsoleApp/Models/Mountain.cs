﻿namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class Mountain : Entity
{
    public decimal Latitude { get; set; }
    public decimal Longitude { get; set; }
    public string GridRef { get; set; } = null!;
    public decimal Height { get; set; }
        
    public string? Feature { get; set; }
    public string? Observations { get; set; }

    public decimal Drop { get; set; }
    public string Col { get; set; } = null!;
    public decimal ColHeight { get; set; }
        
    public int DobihId { get; set; }
}