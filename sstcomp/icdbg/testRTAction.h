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

#ifndef TEST_RT_ACTION_H
#define TEST_RT_ACTION_H

#include "SST.h"

namespace SST::ICDbg{

class TestRTAction : public SST::RealTimeAction
{

public:
    SST_ELI_REGISTER_REALTIMEACTION(
        TestRTAction, 
        "icdbg", 
        "testrtaction", 
        SST_ELI_ELEMENT_VERSION(1, 0, 0),
        "{EXPERIMENTAL} Test user-defined realtime action for use with signals")

    TestRTAction();
    ~TestRTAction() {}

    //void begin() override;
    void execute() override;

};
} // namespace SST::ICDbg

#endif
