local konami = {
   codes = {},
   log = {},
   checking = false,
   timeLeft = 0,
   waitTime = 0.5,
}

function konami.getCodes() return konami.codes end
function konami.getLog() return konami.log end
function konami.getTimeLeft() return konami.timeLeft end
function konami.setWaitTime(v) konami.waitTime = v end

function konami.newCode(code, func)
   local nextref = konami.codes
   for i = 1, #code do
      local key = code[i]
      if not nextref[key] then
         nextref[key] = {
            codes = {},
            functions = {},
         }
      end
      if i == #code then table.insert(nextref[key].functions, func) end
      nextref = nextref[key]["codes"]
   end
end

function konami.update(dt)
   if konami.checking then
      konami.timeLeft = konami.timeLeft - dt
      if konami.timeLeft <= 0 then
         konami.log = {}
         konami.checking = false
      end
   end
end

function konami.keypressed(key)
   table.insert(konami.log, key)
   konami.checking = true
   konami.timeleft = konami.waitTime

   local nextref = konami.codes
   for i = 1, #konami.log do
      local key = konami.log[i]
      if nextref[key] then
         for j = 1, #nextref[key].functions do
            nextref[key].functions[j]()
            konami.log = {}
            konami.checking = false
         end
         nextref = nextref[key]["codes"]
      end
   end
end

return konami
