# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg

# Create a portal context.
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

# Add a raw PC to the request.
scanner = request.RawPC("scanner")
target = request.RawPC("target")
internet = request.XenVM("internet")
fwscanner = request.XenVM("fwscanner")
fwtarget = request.XenVM("fwtarget")

scannerLink = request.Link(members = [scanner, fwscanner])
targetLink = request.Link(members = [target, fwtarget])
targetInternet = request.Link(members = [internet, fwtarget])
scannerInternet = request.Link(members = [internet, fwscanner])

# Install and execute a script that is contained in the repository.
setupcmd = "sudo /local/repository/upgrade.sh >/tmp/output 2>/tmp/error"
scanner.addService(pg.Execute(shell="sh", command=setupcmd))
target.addService(pg.Execute(shell="sh", command=setupcmd))
internet.addService(pg.Execute(shell="sh", command=setupcmd))
fwscanner.addService(pg.Execute(shell="sh", command=setupcmd))
fwtarget.addService(pg.Execute(shell="sh", command=setupcmd))

# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
