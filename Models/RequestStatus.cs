using System;
using System.Collections.Generic;

namespace Server.Models;

public partial class RequestStatus
{
    public long StatusId { get; set; }

    public string Description { get; set; } = null!;

    public virtual ICollection<ConnectionRequest> ConnectionRequests { get; } = new List<ConnectionRequest>();

    public virtual ICollection<LockRequest> LockRequests { get; } = new List<LockRequest>();
}
