const ethers = require("ethers")

const { abi } = require("./MinterAmm.json")
const token_abi = require("./IERC20.json").abi

const mumbai =
  "wss://polygon-mumbai.g.alchemy.com/v2/lwpu306pJ460vsgQIQ294sv4R2jd2I5t"

const key = "b7a51d1e4c89afacb333dd53429a28e863b7d13bcc24a8f1dbdb38cd6f0ba7d0"

const minter_address = "0xc238023eecb8d6eebe252d823e1337974be41cda"

let provider = new ethers.providers.WebSocketProvider(mumbai)
let signer = new ethers.Wallet(key, provider) // ethereum.getSigner()

const minter = new ethers.Contract(minter_address, abi, signer)
const token = new ethers.Contract(
  "0x78Fd7068d0dDD7d70c334d8624f2E42Cb86C7B45",
  token_abi,
  signer,
)

async function deposit() {
  //let amount = ethers.utils.parseEther('2')
  let tx = await token.approve(minter_address, ethers.utils.parseEther("2"))
  console.log(tx.hash)
  await tx.wait()

  tx = await minter.provideCapital(
    ethers.utils.parseEther("2"),
    ethers.utils.parseEther("0"),
  )
  console.log(tx.hash)
  await tx.wait()
}

deposit()
