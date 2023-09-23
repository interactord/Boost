import Foundation
import Architecture
import SwiftUI
import ComposableArchitecture

struct ReviewPage {
  
  private let store: StoreOf<ReviewStore>
  @ObservedObject private var viewStore: ViewStoreOf<ReviewStore>
  
  init(store: StoreOf<ReviewStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
}

extension ReviewPage {
  private var itemListComponentViewState: ItemListComponent.ViewState {
    .init(
      itemList: [
        ItemListComponent.ViewState.ReviewItem(
          author: "Chris Sawin",
          content: "Now the \"Meg\" (2018) itself could never be called a good film, but it is a great deal better than this muddled and derivative effort. \"Jonas\" (Jason Statham) is now working as a sort of eco-policeman trying to stop the dumping of toxic waste into the oceans, and after a snappy \"007\" style opening, he is daringly rescued by \"Mac\" (Clff Curtis) and \"Rigas\" (Melissanthu Mahut) and returned to the research centre where he is reunited with \"Jess\" (Skyler Samuels), \"DJ\" (Page Kennedy) and the adrenalin seeking \"Juiming\" (Jing Wu) who are nursing the daughter of the last megalodon! The team now travel to a remote installation where they must investigate some more of the beasties that live below the frozen layer put there by nature to ensure than we don't mix. Thing is, it seems they are not the only folks who've hit on the idea that there might be untapped riches 25,000 feet below the surface, and soon our team are involved in a contretemps with \"Montes\" (Sergio Peris-Mencheta) that introduces treachery, double-dealing and causes explosions galore that release not just megs, but also an enormous octopus into the ocean where they can merrily terrorise the holidaymakers on the nearby resort of \"Fun Island\". Can \"Jonas\" et al manage to take on four of these super-creatures before they've snacked their way through the tourists? This might have been a bit better if they'd just cut all the preamble and gone straight to the rig and to the underwater action, big fish and pyrotechnics. As it is, we spend far too long meandering about on the surface meeting the characters and there's way too much pointless dialogue throughout - though one or two half-hearted witticisms and puns help a little - before an ending that is entirely predictable and really rather processionally so. The acting is just banal, the continuity is all over the place - as is the editing - and the huge chunk of Ali Baba money that's floated this thing ensures that the switches from the English to Chinese languages actually smacks more of keeping everybody happy in the boardroom rather than engaging anyone in the actual cinema. Simply, even the charismatic Statham cannot rescue this from the doldrums of CGI-led mediocrity that churns out an unremarkable hybrid of \"Jaws\" and \"Jurassic Park\". It does need a big screen. If you wait til it's on the telly then you will be even more disappointed. Mind you, is that actually possible?"),
        ItemListComponent.ViewState.ReviewItem(
          author: "MovieGuys",
          content: "Meg 2 doesn't really feel like a follow up film, to its 2018 counterpart. Indeed, the latest instalment feels more like a platform for various action \"stunts\". \r\n\r\nThe giant,prehistoric shark's are essentially window dressing, for a variety of frenetic action sequences, where things blow up, are torn apart, shot at, harpooned, people gobbled up Jaws and Jurassic Park style and what I can only describe as acrobatic, aquatic scenes with jet ski's and the like, all take place. They even throw in a giant squid, to spice things up. \r\n\r\nOr put more simply, this is a messy mash up, of derivative, often dispirit ideas. Unsurprisingly, the results a bit chaotic, with no compass to direct the viewer, in terms of the story, such as it is. Its quite watchable, in its own way but it never really goes anywhere.\r\n\r\nIn summary, watchable on a very visually superficial level. Lots of action but little in the way of an established story, to pull the whole thing together.")
      
      ])
  }
}

extension ReviewPage: View {
  
  var body: some View {
    ScrollView {
      VStack {
        ItemListComponent(viewState: itemListComponentViewState)
      }
      .background(Color.white)
      .cornerRadius(10)
      .padding(.bottom)
      .padding(.horizontal, 16)
    }

    .background(Color.customBgColor)
  }
}
