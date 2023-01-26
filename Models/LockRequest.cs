using System;
using System.Collections.Generic;

namespace Server.Models;

public partial class LockRequest
{
    public long TcuId { get; set; }

    public long DeviceId { get; set; }

    public DateTime CreationTimeStamp { get; set; }

    public long? StatusId { get; set; }

    public virtual Device Device { get; set; } = null!;

    public virtual RequestStatus? Status { get; set; }

    public virtual Tcu Tcu { get; set; } = null!;
}
