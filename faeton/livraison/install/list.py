import re, os
print "Start ..."
print

zone_var_list = {}

adresse = "D:/myCap/myTemp/2013-04/templates/module/"

for zone in os.listdir(adresse):
    if zone[:2] == 'mt':
        zone_var_list[zone] = []
        
        print ":::",zone, ":::"

        for fil in os.listdir(adresse + "/" + zone):
            print "...",fil
            erb_file = open(adresse + "/" + zone + "/" + fil)
            erb_file_content = erb_file.read()

            tockens = re.findall("<%=(.*?)%>", erb_file_content)

            for tocken in tockens:
                if zone_var_list[zone].count(tocken.strip()) == 0:
                    print "......",tocken
                    zone_var_list[zone].append(tocken.strip())

            erb_file.close()

file_env = open("D:/myCap/myTemp/2013-04/x.end", "w")

for zon in zone_var_list:
    file_env.write("["+zon.upper()+"]\n")
    for var in zone_var_list[zon]:
        file_env.write(var+"=\n")

file_env.close()

