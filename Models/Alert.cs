using System;
using System.Collections.Generic;

namespace Server.Models;

public partial class Alert
{
    public long TcuId { get; set; }

    public string[] ObdCode { get; set; } = null!;

    public DateTime LogTimeStamp { get; set; }

    public virtual ObdCode ObdCodeNavigation { get; set; } = null!;

    public virtual Tcu Tcu { get; set; } = null!;
}
