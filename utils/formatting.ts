export const toUSD = (amount: number | string, cents: boolean = true): string => {
    if(typeof amount === "string") amount = parseFloat(amount)
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD', minimumFractionDigits: cents ? 2 : 0 }).format(amount)
}

export const toReadableDate = (date: Date | string): string => {
    if(typeof date === "string") date = new Date(date)
    return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}

export const toTimestamp = (start_date: Date | string, stop_date: Date | string): string => {
    if(typeof start_date === "string") start_date = new Date(start_date)
    if(typeof stop_date === "string") stop_date = new Date(stop_date)
    const stopDate = stop_date.getTime()
    const startDate = start_date.getTime()
    const duration = stopDate - startDate
    // floor removes any possible floating point numbers
    const seconds: number = Math.floor(((duration / 1000) % 60))
    const minutes: number = Math.floor(((duration / (1000 * 60)) % 60))
    const hours: number = Math.floor((duration / (1000 * 60 * 60)))
    const hoursString = (hours < 10 && hours >= 0) ? '0' + hours : hours
    const minutesString = (minutes < 10 && minutes >= 0) ? '0' + minutes : minutes
    const secondsString = (seconds < 10 && seconds >= 0) ? '0' + seconds : seconds
    return hoursString + ':' + minutesString + ':' + secondsString
}