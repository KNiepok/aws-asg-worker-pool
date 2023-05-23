terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0"
    }
    random = { source = "hashicorp/random" }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "this" {
  default = true
}

data "aws_security_group" "this" {
  name   = "default"
  vpc_id = data.aws_vpc.this.id
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id
}


resource "random_pet" "this" {}

module "my_workerpool" {
  source = "github.com/spacelift-io/terraform-aws-spacelift-workerpool-on-ec2?ref=e954914020a5e1a561038cba27bb9d06438deba6"

  configuration = <<-EOT
    export SPACELIFT_LAUNCHER_BINARIES_DOWNLOAD_URL=https://downloads.spacelift.dev
    export SPACELIFT_TOKEN="eyJicm9rZXIiOnsiZW5kcG9pbnQiOiJhOHo3M3ZjMDlldmx1LWF0cy5pb3QuZXUtd2VzdC0xLmFtYXpvbmF3cy5jb20iLCJwdWJsaXNoX2NoYW5uZWxfZm9ybWF0Ijoic3BhY2VsaWZ0L3dyaXRlb25seS8wMUdKWkY5OVoxOEs0NU5FWjRDVjBBMUJWSi8lcyIsInN1YnNjcmliZV9jaGFubmVsX2Zvcm1hdCI6InNwYWNlbGlmdC9yZWFkb25seS8wMUdKWkY5OVoxOEs0NU5FWjRDVjBBMUJWSi8lcyJ9LCJwb29sX2NlcnQiOiItLS0tLUJFR0lOIENFUlRJRklDQVRFLS0tLS1cbk1JSUVxekNDQTVPZ0F3SUJBZ0lVZnRpWTFWdW5DeUZLODZrcTBhZmdlUUhEdGlzd0RRWUpLb1pJaHZjTkFRRUxcbkJRQXdUVEZMTUVrR0ExVUVDd3hDUVcxaGVtOXVJRmRsWWlCVFpYSjJhV05sY3lCUFBVRnRZWHB2Ymk1amIyMGdcblNXNWpMaUJNUFZObFlYUjBiR1VnVTFROVYyRnphR2x1WjNSdmJpQkRQVlZUTUI0WERUSXlNVEV5T0RFMU5UUTFcbk5Wb1hEVFE1TVRJek1USXpOVGsxT1Zvd2NERUxNQWtHQTFVRUJoTUNVR3d4RkRBU0JnTlZCQWdNQzAxaGVtOTNcbmFXVmphMmxsTVE4d0RRWURWUVFIREFaWFlYSnpZWGN4RWpBUUJnTlZCQW9NQ1ZOd1lXTmxiR2xtZERFbU1DUUdcbkNTcUdTSWIzRFFFSkFSWVhhM0o2ZVhONmRHOW1ia0J6Y0dGalpXeHBablF1YVc4d2dnSWlNQTBHQ1NxR1NJYjNcbkRRRUJBUVVBQTRJQ0R3QXdnZ0lLQW9JQ0FRREZSU1A5cWVCOUhQTiszbEF4UTg4UHpqNEgyVnc4UjdFcHNhckJcbmVsb0l0SVhiL1BEZTZvWTNQbTFTdXI1MGcvNmUzVkJmQ3N3aURlUnl1L3ZSS2pnOE1GdHQ0eHh0WG1Qbk1ENEdcbkJoQTY0dXVqOG1adHRXSTBXMmhtNU5uNEhHSkxkZkJ3ajh5dlN5RFBVSVlpcWZkMW5sYUNaRDJxcjFINmhoeThcbnYyaWNiOEZqMG1RSkZNVXJiOGtldVZ2cjhmQTcydnpvUjF5T2pxVktwZFQ5MXRYSGlKa0xlM2ZOZThIZklpWkFcbk56Z0hieGl4b1BQbDQ2ai9zLzNPNUF3S080cWNQSkZTY1BTa3lCdDJxSW5kUEhFbmthNkFSSUpBY2pWMW0xVDlcbmdUUUJNQnA2K3hMTmNUd1BWUVRJSjlyZXFUcWJVdXdJei8xbXlRTVpFL1hZS3BhNlZmakRQT2hOTzMxUDEvTzBcbjNvUWlQNkdTeXJMeTNHeC8zNHFLUCtXZkFzbnBQc1VSbW1kRU5LUTJRM2xBaDYvV2l5bk1nc1pITXhpSjltZ3RcbmRvM3FUL05QSmxaejIwVEx1WjdCYnhiRzVKemtZK0lVOWFUT2wrTUFXMG9td2tlUnNiUllnRHZjYytodzlMSWlcblFlY0laR2pDOG03Y290Syt4YkJRaDEwVGo1SFhubGgzSGllSURaM3UyMDhkd1FHditEMlF5aU9udmZ0bE0yUXdcbi84YkhjQ1NZM3dkMENKZXFmdmdTeVFibm55bEZhbUNCWitrZ09CRnNPQnI4cXNxeWQwR1V1c3FWNnlJSnJRZXlcblpBQkVUZ2xJeCtLR0FDbm04aTRpN295MHNwQlR5UkZDOWVnZ0hZd3BFMUF1ZlQwQ0FpNVA0VUt1SlF1ejNFUUFcbjcvbkErUUlEQVFBQm8yQXdYakFmQmdOVkhTTUVHREFXZ0JSM29hVzdsQzFZbzdZdk1UNzM0VkNocGZqVXV6QWRcbkJnTlZIUTRFRmdRVUdKTzdRTkh5T3BGaWVXbHdtdWprbUxtZWUvQXdEQVlEVlIwVEFRSC9CQUl3QURBT0JnTlZcbkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBRkVJalQwQTVIblNVRHk3NzloRkNvdE5cbmFwemxaYURxQzVvcFR0V0xVTUlyZElPYzA4Y0tTZ1FMZXBnWTdNVmxBMFlvYnc2MUhIbFhwV3R3K2N6RmNWYmlcbkptbnEzVzRxZ3d0QngwQTh1VmNuRnpTV2FDMXNhR21ua1YwSWtnZ2p0RHdpaHdndS9qZHJ2QThkVXpGRlZia2tcblhkdnVkc1VrOUFkNEMxbFRnOG50K3F4R0ZwZUpRdEpFR0tiUkFycUJQZHYyQ3BTS2xTQUNEMkUvYWtaUDcrakFcbitxNlhyekJ1U0tJTmp4b001eFg3Yk4xbHhPWTBPdi80b0lWek9meHltYk14SXdkajlWWDNsVTdhWmUrdmpLbGtcbkdxbWdDWXpJT2FVdGZGWVhnOGpsNUdpZXdQZUIrOHNLUEw5Z25wU0RLV3NVYklTUHBEMkVJeDNxVXFwUHcwST1cbi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS1cbiIsIndvcmtlcl9wb29sX3VsaWQiOiIwMUdKWkY5OVoxOEs0NU5FWjRDVjBBMUJWSiJ9"
    export SPACELIFT_POOL_PRIVATE_KEY="LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUpRZ0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQ1N3d2dna29BZ0VBQW9JQ0FRREZSU1A5cWVCOUhQTisKM2xBeFE4OFB6ajRIMlZ3OFI3RXBzYXJCZWxvSXRJWGIvUERlNm9ZM1BtMVN1cjUwZy82ZTNWQmZDc3dpRGVSeQp1L3ZSS2pnOE1GdHQ0eHh0WG1Qbk1ENEdCaEE2NHV1ajhtWnR0V0kwVzJobTVObjRIR0pMZGZCd2o4eXZTeURQClVJWWlxZmQxbmxhQ1pEMnFyMUg2aGh5OHYyaWNiOEZqMG1RSkZNVXJiOGtldVZ2cjhmQTcydnpvUjF5T2pxVksKcGRUOTF0WEhpSmtMZTNmTmU4SGZJaVpBTnpnSGJ4aXhvUFBsNDZqL3MvM081QXdLTzRxY1BKRlNjUFNreUJ0MgpxSW5kUEhFbmthNkFSSUpBY2pWMW0xVDlnVFFCTUJwNit4TE5jVHdQVlFUSUo5cmVxVHFiVXV3SXovMW15UU1aCkUvWFlLcGE2VmZqRFBPaE5PMzFQMS9PMDNvUWlQNkdTeXJMeTNHeC8zNHFLUCtXZkFzbnBQc1VSbW1kRU5LUTIKUTNsQWg2L1dpeW5NZ3NaSE14aUo5bWd0ZG8zcVQvTlBKbFp6MjBUTHVaN0JieGJHNUp6a1krSVU5YVRPbCtNQQpXMG9td2tlUnNiUllnRHZjYytodzlMSWlRZWNJWkdqQzhtN2NvdEsreGJCUWgxMFRqNUhYbmxoM0hpZUlEWjN1CjIwOGR3UUd2K0QyUXlpT252ZnRsTTJRdy84YkhjQ1NZM3dkMENKZXFmdmdTeVFibm55bEZhbUNCWitrZ09CRnMKT0JyOHFzcXlkMEdVdXNxVjZ5SUpyUWV5WkFCRVRnbEl4K0tHQUNubThpNGk3b3kwc3BCVHlSRkM5ZWdnSFl3cApFMUF1ZlQwQ0FpNVA0VUt1SlF1ejNFUUE3L25BK1FJREFRQUJBb0lDQURHNUhyeEdnRzRveVB0V2YvSWEvR3NvCmVod3lYbnhYT2NHZnBjSEUzRUxMZGQ0Z1lIcGZ0TnJoNGw1eThhU2V6S1F3ZHB5dU5RdjBZbnZGQkZFUmlrRXAKa3pJY2g4TE5ndkw0QnZvdnR4R1F0d0tKQytabFRNNlRwN29mdncwNTRsRFE5bno0MGdmeE1PRHdsQTdTdHF3dgo3L0JINGY5TzE2UUUvK05YZjcvR3I0RkF1N1JLUnZTTzVhdlgzdUtYQmcyZ1FoVXVQNWN6UDFpVWVoNU5jMjhxCjhDQ2p5MnZBNFBva09tMy9QU0Vxa0pmZFVQekdLSWZqVDN0Qm9nTkdSTWJpd1dKOVZEemdyNE4yTWVIUTVWaXEKOE1nbC9JclAvc2VaRXBBZmJBTk1vN0FSN3doWG5XTGo5Q09iWUNDMW1TOGpkSms0QzlCSHBIOUN0N24zNml1MgpCWVlYN1lLT2xHQmEzZDZJMEtOOFlJWDJveC9HUjBHMWNjTzhEQlNYN2dmSEhyeCt4bDlaMXZpUDFMazlueG5iCnhzamFua1pibjVWMlpvakVPZ2pGSGNKV0ViRC9vaml6MHBmRVFGanl3Z3RBZU02SUZaRzI1b0ZYaFBuOHdlOEEKeGFYM2xEbWJQMnBJbG16d2hFWmR3VHpXNkxRSHNrczE5UllxK0xuNVZDazUrOUV1SmhRTWo0WEhBZGszMEF3SQpNdTVtVUFGTGN4Y3F2bTBpZ3pTL3hMNjJSZHB0dURzR3ZKaXE3bFpGcjh1ZUxEaml6TnRoT3N0enZORGpIZ00wClZCeFlsMzJzaFZCZEl6cHNLZGpraG5jaUxham1Xc0djeWsyMzZpbm95NEVHS0VONTVpNnZEUFJURzRLclNzT2YKRTd4cE1qNGR4SUVISmVDUGltNkJBb0lCQVFEdzlBeVduTEd1emoxN3lRSW1XQ2E2STMzYzQ0U25nQytjelczawpkbFBVYm1TV2N5UGRYU2o2QjRhV05oVEROOTZ2K0lsWngwWDR5cGNsbFRnTHhmNlhlZjIwTG52SDk5amN2TDBECkZZb1puc0JtdDQ3aHZZUnBmOHFyYkdpU3NFbE42RE9MbncrM0pyL0FKbEpMOVJ6N2NqRGlPbXA3YlZlL3VnS1kKUzBzZnVVZGVXOXU2T0REc20yVDZNYmRmU2hjQUF0WndFWUIzdklJQTVuRjhEQlBvcWVUMkhoOU03ak5ZTy9NMgpKU0ZyMVh2NGs0M09IUUFEd1FLU0tPV1NoOW5iVEV0VDZzelhIM0hpVUJCZllpamt5Q29VN0x0NGVyYWc2d3VWCmpNVWk1a0gySEZmSDRFNUFkeHN3UHlUeTlOMUFSVUxuZEk5UXdXSnBoRi9NaFZ3eEFvSUJBUURSbHNJZ1IrRjQKMVRZcnFDQ0p5U0xTaDR1YTFocDc2bkJFYTZ0dVpBeFczNDlOUS9ESWtrOXJxK256SXFRWlE3d2RzbWc1TkV6bgpGYmtTc0FwbmQ3VHZiMFRWY21yRUV5OWRGbWVQZ2VTY2xCT3RnbERnanpEU0FUTjBlYjhXdi85MnpYTStrQXJuCnV2Vkk3ZnJIMmttNTVXL1QxWjVzYW9TYWo2bnd3cU9aVklTUUQ0YlRjeFJ6R3hUQ0RHMUlnN01RTkUyQ3J0NUcKYVAvbW0zRmMwMlppVHlIazE2YzNZZHMzeWFsbURGT2c2RjdPM1VqcHdJQUI0aGVnMDlCMWhvU1QyU0lXL1BLQQpsWjRmams3eVI3VnUzOVZIUWMzZ2tSUDI0aEgzZWg2SXZ3Smc1RitMNnlRRzFteC9RRDdhblBZd3hjVncrQ1R2ClhyYzliSDJzbHlkSkFvSUJBUURRZmh3MlpyZkl6bVNkSzcxVWVJcHFIalBXWW5oeWg1U3JWWVoxWFg0RUh0R2kKN1ZablFTa24wRU5BenVNQVdPT3oySmJndkhGcmFjR0huNnF6WlV0NnZ2QXNiTnhtbDZ0cXRWWEh5V2VKNjdnSQpLV1RWS0N2ZkxkaXNwRTJJUUVudHc3SjJhZGdyWHJnbENBUEYvZjVxQk5FUHNBUmJjSzJ4Rkw4U0VIU2NxckY2CmtIbDhsUXFnY1lYYWlCSm52YkJSTGlObkxYM0FIYmxRRmhhMGc2N21iN3ZTeXhYQ2Q0cXVHcEhFbERSckhucjcKQ0pKM2V0aDhaeEpXYmxUWGlmMlVxRnUxN1VINkV4ZDBBRnRxYllGOUZVWjBmTE5xK0tQMmNldkFKK0tjNUNqSApVSmNVT0o3OVlSS0JtT0hiNk0xWnc1UzB1a01ZV1gxU1dGeWNsL2pCQW9JQkFFdTdmdi90R1ZMeEwvYk1kSjExCkdXa2JZMTJhbWMxRzVEUkU5NWdXL01Kelc3T2VwaVhEZ0lFMmlIMjdlYkpMWUhFV28wUndXbzF4c3dOR3F5dkIKL0pZOERaSlhHcThwQTRkT2JqTlR5MGlzMVFOd1FFczBVbjYvd2xrSEdQNWVlQy8wZ3YwTFRYVjRmK05QWXJ2TwphNitKY1VRSlA0cUxYc2ordW5odHpIRytNWHhncitZK0FoaXBvM0dPemZwUzVHUXBrZ3h6cFl1cHF6WW4ydW1nCjFiRVdTUGdJMkxwUldNWXF6MVE1aGdweGpMaVJDeVN6MDAxYTVoRE9HTmd1dUQ4NFNYSW5DblZlR3RucU1TcW8Kc0syVW9kdHlzcksvbVlndkhqRGZacU1nNmZvYTYwK0NzdXpwbENEVEZTTW5ibW9uUEhYYXBIWCtNcFkyV3A3LwpxMGtDZ2dFQWF0TmxRV21ZQWprVzE2QWR4ckVQNXlHQ3pmcU9yN2FuYUNTbHRhb3ZTazVVRHk1d3RCbzJPTGF3ClQzYjVCM0lEdkg1WWhvVzZXVkx0R0xIQ3VrbG1zL0tqejJXL2htUHJkZlhRMnZrSmwwcTdZVzdoVEhndkt2NnUKTTlsRHNOSG1Eb2JDTGhtdXhmK3N3RFhXR1RiZTBTZzZNR01JZzhaalBNZjRVclErWGdIZFJ5RXNoUkEwelBhRApLaDBRM2R1Um1ZcVJ6S1cybVVyam56cVVRV2RYY1FzOFZkNGt4cTFJY3V5N0RtYm02aGlmaTlGb2ZyUFBESktSCkhMdUVTdGZiY0pkdmJvSGhsM0h0VUFHT055VCtydVNYTlcvQ0liN0Nwc0YrVVVxUng4SE5HUk1nb00xS0c1Sy8KTU5xYnRCdUtpLytuNk1wcFZFR3pZZnNUTllCaXVBPT0KLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLQo="
  EOT

  domain_name       = "spacelift.dev"
  min_size          = 2
  max_size          = 2
  ami_id            = "ami-05e4f0213f203e902"
  worker_pool_id    = random_pet.this.id
  security_groups = [data.aws_security_group.this.id]
  vpc_subnets     = data.aws_subnet_ids.this.ids
}
