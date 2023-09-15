<script setup lang="ts">
type Calculation = {
    name: string
    total: number
    donation: number
}
const calced: Ref<Calculation[]> = ref<Calculation[]>([])
const total: Ref<number> = ref<number>(10000)
const totalField: Ref<number> = ref<number>(100.0)
const minimumDonation: Ref<number> = ref<number>(100)

function isPalindrome(total: number) {
    const totalS = total.toString()
    if (totalS === totalS.split('').reverse().join('')) {
        return true
    } else {
        return false
    }
}
function teamPalindrome(total: number) {
    const holder = total
    for (;;) {
        total++
        if (isPalindrome(total) === true) {
            if (toDollars(total - holder) > 1.00) {
                const tot = total
                const don = total - holder
                return { tot, don }
            }
        }
    }
}
function teamFixers(total: number) {
    const cents = 100 - (total % 100)
    let tot = total + cents + minimumDonation.value
    let don = cents + minimumDonation.value
    if (don === 200) {
        tot = tot - 200
        don = 0
    }
    return { tot, don }
}
function primeHunters(total: number) {
    const holder = total
    for (;;) {
        total++
        if (isPrime3(total) === true) {
            if (toDollars(total - holder) > 1.00) {
                const tot = total
                const don = (total - holder)
                return { tot, don }
            }
        }
    }
}
function altDigit(total: number) {
    const intAL = [parseInt((total + minimumDonation.value).toString().substr(0, 1)), parseInt((total + minimumDonation.value).toString().substr(1, 1)) - 1]
    let intAL1 = 1
    let intAL2 = intAL[0]
    let intALlen = (total + minimumDonation.value).toString().length
    while (intAL2 < (total + minimumDonation.value)) {
        intAL[1] = intAL[1] + 1
        if (intAL[1] === intAL[0]) {
            intAL[1] = intAL[1] + 1
        }
        if (intAL[1] >= 10) {
            intAL[0] = intAL[0] + 1
            intAL[1] = 0
            if (intAL[0] === 10) {
                intAL[0] = 1
                intALlen = intALlen + 1
            }
        }
        intAL2 = intAL[0]
        intAL1 = 1
        while (intAL2.toString().length < intALlen) {
            intAL2 = parseInt(intAL2.toString().concat(intAL[intAL1].toString()))
            intAL1 = 1 - intAL1
        }
    }
    const tot = intAL2
    const don = tot - total
    return { tot, don }
}
function stepdigitUp(total: number) {
    let intSUlen = (total + minimumDonation.value).toString().length
    let intSUstart = parseInt((total + minimumDonation.value).toString().substr(0, 1))
    let intSU1 = 0
    let intSU2 = 0
    intSUstart = intSUstart - 1
    let booSUerr = false
    while ((intSU1 < (total + minimumDonation.value)) && (booSUerr === false)) {
        intSUstart = intSUstart + 1
        if ((intSUstart + intSUlen) > 10) {
            intSUstart = 1
            intSUlen = intSUlen + 1
        }
        if (intSUlen === 10) {
            booSUerr = true
        }
        intSU2 = intSUstart
        intSU1 = intSUstart
        while (intSU1.toString().length < intSUlen) {
            intSU2 = intSU2 + 1
            intSU1 = parseFloat(intSU1.toString().concat(intSU2.toString()))
        }
    }
    const tot = intSU1
    const don = tot - total
    //   if (booSUerr === false) {
    //     locate('sutot', (intSUTot))
    //     locate('sudon', (intSUDon))
    //   }
    return { tot, don }
}
function stepdigitDown(total: number) {
    let intSDlen = (total + minimumDonation.value).toString().length
    let intSDstart = parseInt((total + minimumDonation.value).toString().substr(0, 1))
    intSDstart = Math.max(intSDstart, (intSDlen - 1))
    let intSD1 = 0
    let intSD2 = 0
    intSDstart = intSDstart - 1
    let booSDerr = false
    while ((intSD1 < (total + minimumDonation.value)) && (booSDerr === false)) {
        intSDstart = intSDstart + 1
        if (intSDstart >= 10) {
            intSDlen = intSDlen + 1
            intSDstart = intSDlen - 1
        }
        if (intSDlen > 10) {
            booSDerr = true
        }
        intSD2 = intSDstart
        intSD1 = intSDstart
        while (intSD1.toString().length < intSDlen) {
            intSD2 = intSD2 - 1
            intSD1 = parseFloat(intSD1.toString().concat(intSD2.toString()))
        }
    }
    const tot = intSD1
    const don = tot - total
    //   if (booSDerr === false) {
    //     return { intSDTot, intSDDon }
    //   }
    return { tot, don }
}
function repDigit(total: number) {
    let intRD1 = parseInt((total + minimumDonation.value).toString().substr(0, 1))
    let intRDlen = (total + minimumDonation.value).toString().length
    let intRD2 = intRD1
    while (intRD2.toString().length < intRDlen) {
        intRD2 = parseFloat(intRD2.toString().concat(intRD1.toString()))
    }
    while (intRD2 < (total + minimumDonation.value)) {
        intRD1 = intRD1 + 1
        if (intRD1 === 10) {
            intRD1 = 1
            intRDlen = intRDlen + 1
        }
        intRD2 = intRD1
        while (intRD2.toString().length < intRDlen) {
            intRD2 = parseFloat(intRD2.toString().concat(intRD1.toString()))
        }
    }
    const tot = intRD2
    const don = tot - total
    return { tot, don }
}
function twoToTheN(total: number) {
    let int2N1 = 1
    let int2N2 = 2
    while (int2N2 < (total + minimumDonation.value)) {
        int2N1 = int2N1 + 1
        int2N2 = Math.pow(2, int2N1)
    }
    const tot = int2N2
    const don = tot - total
    return { tot, don }
}
function fibbonacci(total: number) {
    const arrFB = new Array(2)
    arrFB[1] = 1
    arrFB[2] = 1
    let intFB = 2
    while (arrFB[intFB] < (total + minimumDonation.value)) {
        intFB = intFB + 1
        arrFB[intFB] = arrFB[intFB - 2] + arrFB[intFB - 1]
    }
    const tot = arrFB[intFB]
    const don = tot - total
    return { tot, don }
}
function isPrime3(n: number) {
    if (isNaN(n) || !isFinite(n) || n % 1 || n < 2) { return false }
    if (n % 2 === 0) { return (n === 2) }
    if (n % 3 === 0) { return (n === 3) }
    const m = Math.sqrt(n)
    for (let i = 5; i <= m; i += 6) {
        if (n % i === 0) { return false }
        if (n % (i + 2) === 0) { return false }
    }
    return true
}
function toCents(total: number) {
    total = Math.round(parseFloat(total.toString().replace(',', '')) * 100)
    return total
}
function toDollars(total: number) {
    total = total / 100
    return total
}
function runCalcs() {
    calced.value = []
    const fix = teamFixers(total.value)
    calced.value.push({
        name: 'Fixers',
        total: fix.tot,
        donation: fix.don
    })
    const palindrome = teamPalindrome(total.value)
    calced.value.push({
        name: 'Palindrome',
        total: palindrome.tot,
        donation: palindrome.don
    })
    const prime = primeHunters(total.value)
    calced.value.push({
        name: 'Prime',
        total: prime.tot,
        donation: prime.don
    })
    const fib = fibbonacci(total.value)
    calced.value.push({
        name: 'Fibbonacci',
        total: fib.tot,
        donation: fib.don
    })
    const two = twoToTheN(total.value)
    calced.value.push({
        name: '2^n',
        total: two.tot,
        donation: two.don
    })
    const stepUp = stepdigitUp(total.value)
    calced.value.push({
        name: 'Stepdigit Up',
        total: stepUp.tot,
        donation: stepUp.don
    })
    const stepDown = stepdigitDown(total.value)
    calced.value.push({
        name: 'Stepdigit Down',
        total: stepDown.tot,
        donation: stepDown.don
    })
    const rep = repDigit(total.value)
    calced.value.push({
        name: 'Repdigit',
        total: rep.tot,
        donation: rep.don
    })
    const altDigitV = altDigit(total.value)
    calced.value.push({
        name: 'Alternating Digits',
        total: altDigitV.tot,
        donation: altDigitV.don
    })
}
runCalcs()
watch(totalField, () => {
    total.value = toCents(totalField.value)
    runCalcs()
})
</script>
<template>
  <div class="flex justify-center">
    <div class="max-w-2xl min-w-full">
      <h1 class="text-3xl my-3 text-center font-bold">
        Donation Calculator
      </h1>
      <div>
        <label
          for="price"
          class="block text-sm font-medium leading-6 text-gray-900 dark:text-gray-100"
        >Donation Total</label>
        <div class="relative my-2 rounded-md shadow-sm">
          <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
            <span class="text-gray-500 sm:text-sm">$</span>
          </div>
          <input
            id="price"
            v-model="totalField"
            type="text"
            name="price"
            class="block w-full rounded-md border-0 py-1.5 pl-7 pr-12 text-gray-900 dark:text-gray-100 ring-1 ring-inset ring-gray-300 dark:ring-gray-700 placeholder:text-gray-400 dark:placeholder:text-gray-600 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6 dark:bg-black"
            placeholder="0.00"
            aria-describedby="price-currency"
          >
        </div>
      </div>
      <div class="flow-root">
        <div class="-mx-4 -my-2 sm:-mx-6 lg:-mx-8 sm:rounded-lg">
          <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
            <div class="shadow ring-1 ring-black dark:ring-gray-700 ring-opacity-5 sm:rounded-lg overflow-auto">
              <table class="relative min-w-full divide-y divide-gray-300 dark:divide-gray-700">
                <thead class="bg-gray-50 dark:bg-slate-700 sticky top-0">
                  <tr>
                    <th
                      scope="col"
                      class="py-3.5 pl-4 pr-1 text-left text-sm font-semibold text-gray-900 dark:text-gray-100 sm:pl-3"
                    >
                      Type
                    </th>
                    <th
                      scope="col"
                      class="px-2 py-3.5 text-left text-sm font-semibold text-gray-900 dark:text-gray-100"
                    >
                      Preview Total
                    </th>
                    <th
                      scope="col"
                      class="px-2 py-3.5 text-left text-sm font-semibold text-gray-900 dark:text-gray-100"
                    >
                      Amount Required
                    </th>
                  </tr>
                </thead>
                <tbody
                  class="divide-y divide-gray-200 bg-white dark:bg-slate-800 dark:divide-gray-700"
                >
                  <tr
                    v-for="calc in calced"
                    :key="calc.name + calc.total"
                  >
                    <td class="p-2">
                      {{ calc.name }}
                    </td>
                    <td class="p-2">
                      {{ toUSD(calc.total/100) }}
                    </td>
                    <td class="p-2">
                      {{ toUSD(calc.donation/100) }}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
      <h6 class="my-2 text-sm">
        Powered by <a href="https://0rganics.org">0rganic's</a> original functions
      </h6>
    </div>
  </div>
</template>
