# Fact: kernel_arguments
#
# Purpose:
#   This fact provides the arguments used for the currently running kernel
#
# Resolution:
#   Checks `proc/cmdline`
#
# Caveats:
#   Only supports Linux.
#

Facter.add(:kernel_arguments) do
  confine :kernel => :linux
  setcode do
    cmdline_out = Facter::Util::Resolution.exec('cat /proc/cmdline 2>/dev/null')
    cmdline_out
  end
end
