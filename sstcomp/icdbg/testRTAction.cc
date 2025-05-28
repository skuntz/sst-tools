// Copyright 2009-2025 NTESS. Under the terms
// of Contract DE-NA0003525 with NTESS, the U.S.
// Government retains certain rights in this software.
//
// Copyright (c) 2009-2025, NTESS
// All rights reserved.
//
// This file is part of the SST software package. For license
// information, see the LICENSE file in the top level directory of the
// distribution.

#include "testRTAction.h"

namespace SST::ICDbg {

TestRTAction::TestRTAction() : RealTimeAction() {}

#if 0
void
TestRTAction::begin()
{
    printf("begin(): Test realtime action at sim cycle %ld\n", getCurrentSimCycle());
}
#endif

void
TestRTAction::execute()
{
    printf("Test realtime action at sim cycle %ld\n", getCurrentSimCycle());
}

} // namespace SST::IMPL::Interactive
