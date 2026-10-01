import Agentic
import AgenticIO

public extension CoreSkillProvider {
    static let debuggingLoop = AgentSkill(
        identifier: "debugging-loop",
        name: "Debugging loop",
        summary: "Turn failures into a small hypothesis, inspect evidence, patch minimally, and re-check.",
        body: """
        Use a tight debugging loop.

        Workflow:
        1. Restate the observed failure in concrete terms.
        2. Separate symptoms from likely causes.
        3. Identify the smallest code, data, or configuration region that could explain the failure.
        4. Inspect that region before proposing a fix.
        5. Form one primary hypothesis and, if useful, one fallback hypothesis.
        6. Make the smallest change that addresses the primary hypothesis.
        7. After the change, explain what would need to be run or inspected to verify it.

        When tools are available:
        - Use `\(SystemIO.Tools.FindPaths.identifier.rawValue)` when the failing file is unknown but path names or concepts can narrow it.
        - Use `\(SystemIO.Tools.SearchSources.identifier.rawValue)` with failing identifiers, symbols, messages, or hypotheses to locate likely source regions.
        - Use `\(SystemIO.Tools.LoadSearchContext.identifier.rawValue)` to inspect the strongest search candidates before patching.
        - Use `\(SystemIO.Tools.ReadFile.identifier.rawValue)` when an exact source region is already known or a direct fallback read is appropriate.
        - Use `\(SystemIO.Tools.ScanPaths.identifier.rawValue)` when filesystem topology itself must be inspected.
        - Use `\(SystemIO.Tools.MutateFiles.identifier.rawValue)` with edit_text for small patches and replace_text for whole-file replacement.

        Debugging discipline:
        - Do not rewrite working code to fit a preferred style.
        - Do not fix unrelated issues discovered along the way.
        - Do not claim verification happened unless a tool or user-provided output supports it.
        - If no runner or test tool exists, state the verification gap explicitly.
        """,
        metadata: .init(
            domains: [
                .core
            ],
            tools: .init(
                optional: [
                    .tool(SystemIO.Tools.FindPaths.identifier),
                    .tool(SystemIO.Tools.SearchSources.identifier),
                    .tool(SystemIO.Tools.LoadSearchContext.identifier),
                    .tool(SystemIO.Tools.ReadFile.identifier),
                    .tool(SystemIO.Tools.ScanPaths.identifier),
                    .tool(SystemIO.Tools.MutateFiles.identifier)
                ]
            ),
            tags: [
                "core",
                "debugging",
                "workflow"
            ],
            attributes: [
                "pack": "base",
                "kind": "workflow"
            ]
        )
    )
}
