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

#ifndef INTERACTIVE_CONSOLE_DEBUG_H
#define INTERACTIVE_CONSOLE_DEBUG_H

#include "SST.h"
//#include "sst/core/eli/elementinfo.h"
//#include "sst/core/interactiveConsole.h"


namespace SST::ICDbg{

class ICDebug : public SST::InteractiveConsole
{

public:
    SST_ELI_REGISTER_INTERACTIVE_CONSOLE(
        ICDebug, "sst", "icdbg", SST_ELI_ELEMENT_VERSION(1, 0, 0),
        "{EXPERIMENTAL} Simple interactive debugging console for interactive mode.")

    /**
       Creates a new self partition scheme.
    */
    ICDebug(Params& params);

    void execute(const std::string& msg) override;

private:
    // This is the stack of where we are in the class hierarchy.  This
    // is needed because when we advance time, we'll need to delete
    // any ObjectMap because they could change during execution.
    // After running, this will allow us to recreate the working
    // directory as far as we can.
    std::vector<std::string> name_stack;

    SST::Core::Serialization::ObjectMap* obj_ = nullptr;
    bool                                 done = false;

    std::vector<std::string> tokenize(std::vector<std::string>& tokens, const std::string& input);

    void cmd_help(std::vector<std::string>& UNUSED(tokens));
    void cmd_pwd(std::vector<std::string>& UNUSED(tokens));
    void cmd_ls(std::vector<std::string>& UNUSED(tokens));
    void cmd_cd(std::vector<std::string>& tokens);
    void cmd_print(std::vector<std::string>& tokens);
    void cmd_set(std::vector<std::string>& tokens);
    void cmd_time(std::vector<std::string>& tokens);
    void cmd_run(std::vector<std::string>& tokens);
    void cmd_shutdown(std::vector<std::string>& tokens);

    void dispatch_cmd(std::string cmd);
};

} // namespace SST::IMPL::Interactive

#endif
