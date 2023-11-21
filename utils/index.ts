export function getDurationNumberal(start: Date | string, stop: Date | string) {
    const startDate = new Date(start).getTime()
    const stopDate = new Date(stop).getTime()
    const duration = stopDate - startDate
    let seconds = Math.floor((duration / 1000) % 60)
    let minutes = Math.floor((duration / (1000 * 60)) % 60)
    let hours = Math.floor((duration / (1000 * 60 * 60)))
    hours = hours / 24
    minutes = minutes / 1440
    seconds = seconds / 86400
    return (hours + minutes + seconds) * 24
}
export async function combineLazyAsyncQuery<T>(query: any, combinedData: T) {
    const { data } = await useLazyAsyncQuery<T>(query)
    return {...combinedData, ...data}
}