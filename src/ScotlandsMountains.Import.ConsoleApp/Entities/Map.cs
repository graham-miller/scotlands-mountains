﻿namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class Map : Entity
{
    public string Code { get; set; } = null!;

    public double Scale { get; set; }
    
    public List<Mountain> Mountains { get; set; } = new();

    public override string ToString()
    {
        return $"1:{1/Scale:#,##0}: {Code} ({Id})";
    }
}