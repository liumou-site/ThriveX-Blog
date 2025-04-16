import { getTagListWithArticleCountAPI } from "@/api/tag"
import { Tag } from "@/types/app/tag"
import TagCloudBackground from "@/app/tags/components/TagCloudBackground"
import TagItemCard from "./components/TagItemCard"

export default async () => {
  const { data } = await getTagListWithArticleCountAPI() || { data: {} as Tag[] }

  return (
    <div className="py-[50px] mt-[60px] h-screen overflow-scroll hide_sliding">
      <h1 className="relative z-20 text-4xl font-bold text-center">标签页</h1>
      
      <div className="relative z-20 flex flex-wrap justify-center w-11/12 mx-auto py-10 px-0 sm:px-10">
        {data.map((tag, index) => (
          <TagItemCard data={tag} count={tag.count || 0} index={index} key={tag.id} />
        ))}
      </div>

      <TagCloudBackground tags={data?.map((item: Tag) => item.name) || []} />
    </div>
  )
}