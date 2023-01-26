using System;
using System.Collections.Generic;

namespace Server.Models;

public partial class ObdCode
{
    public string[] ObdCode1 { get; set; } = null!;

    public string Description { get; set; } = null!;

    public bool? IsGeneric { get; set; }

    public virtual ICollection<Alert> Alerts { get; } = new List<Alert>();
}
