using System;
using System.Collections.Generic;

namespace Server.Models;

public partial class ObdFaultAreaCode
{
    public char AreaId { get; set; }

    public string Description { get; set; } = null!;
}
